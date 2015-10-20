// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include "pch.h"
#import <moai-ios/MOAIDialogIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
/**	@lua	showDialog
	@text	Show a native dialog to the user.
				
	@in		string		title			The title of the dialog box. Can be nil.
	@in		string		message			The message to show the user. Can be nil.
	@in		string		positive		The text for the positive response dialog button. Can be nil.
	@in		string		neutral			The text for the neutral response dialog button. Can be nil.
	@in		string		negative		The text for the negative response dialog button. Can be nil.
	@in		bool		cancelable		Specifies whether or not the dialog is cancelable
	@opt	function	callback		A function to callback when the dialog is dismissed. Default is nil.
	@out 	nil
*/
int MOAIDialogIOS::_showDialog ( lua_State* L ) {
	
	MOAILuaState state ( L );
	
	cc8* title = state.GetValue < cc8* >( 1, "" );
	cc8* message = state.GetValue < cc8* >( 2, "" );
	cc8* positive = state.GetValue < cc8* >( 3, nil );
	cc8* neutral = state.GetValue < cc8* >( 4, nil );
	cc8* negative = state.GetValue < cc8* >( 5, nil );
	bool cancelable = state.GetValue < bool >( 6, false );

	__block UIAlertController *alertController =
	[UIAlertController
	 alertControllerWithTitle:[NSString stringWithUTF8String:title]
	 message:[NSString stringWithUTF8String:message]
	 preferredStyle:UIAlertControllerStyleAlert];
	
	__block UIAlertAction *cancelAction = nil;
	__block UIAlertAction *positiveAction = nil;
	__block UIAlertAction *neutralAction = nil;
	__block UIAlertAction *negativeAction = nil;
	__block MOAILuaStrongRef callback = NULL;

	if (state.IsType(7, LUA_TFUNCTION)) {
		callback.SetRef(state, 7);
	}

	void (^dismissHandler)(UIAlertAction * action) = ^(UIAlertAction *action) {
		if (callback != NULL) {
			int dialogResult = -1;
			if (action == positiveAction) {
				dialogResult = MOAIDialogIOS::DIALOG_RESULT_POSITIVE;
			} else if (action == neutralAction) {
				dialogResult = MOAIDialogIOS::DIALOG_RESULT_NEUTRAL;
			} else if (action == negativeAction) {
				dialogResult = MOAIDialogIOS::DIALOG_RESULT_NEGATIVE;
			} else if (action == cancelAction) {
				dialogResult = MOAIDialogIOS::DIALOG_RESULT_CANCEL;
			}

			MOAIScopedLuaState state = callback.GetSelf ();
			state.Push(dialogResult);
			state.DebugCall(1, 0);
		}
	};

	if (positive != nil) {
		positiveAction = [UIAlertAction actionWithTitle:[NSString stringWithUTF8String:positive] style:UIAlertActionStyleDefault handler:dismissHandler];
		[alertController addAction:positiveAction];
	}
	
	if (neutral != nil) {
		neutralAction = [UIAlertAction actionWithTitle:[NSString stringWithUTF8String:neutral] style:UIAlertActionStyleDefault handler:dismissHandler];
		[alertController addAction:neutralAction];
	}
	
	if (negative != nil) {
		negativeAction = [UIAlertAction actionWithTitle:[NSString stringWithUTF8String:negative] style:UIAlertActionStyleDefault handler:dismissHandler];
		[alertController addAction:negativeAction];
	}
	
	if (cancelable) {
		cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:dismissHandler];
		[alertController addAction:cancelAction];
	}
	
	UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
	[window.rootViewController presentViewController:alertController animated:YES completion:nil];

#if 0
	LuaAlertView* alert = [[ LuaAlertView alloc ] initWithTitle:[ NSString stringWithUTF8String:title ] message:[ NSString stringWithUTF8String:message ] cancelButtonTitle:(( cancelable ) ? @"Cancel" : nil )];
	
	if ( state.IsType ( 7, LUA_TFUNCTION )) {
		
		alert->callback.SetRef ( state, 7 );
	}	
	
	if ( positive != nil ) {
		
		alert->positiveButtonIndex = ( int )[ alert addButtonWithTitle:[ NSString stringWithUTF8String:positive ]];
	}

	if ( neutral != nil ) {
		
		alert->neutralButtonIndex = ( int )[ alert addButtonWithTitle:[ NSString stringWithUTF8String:neutral ]];
	}

	if ( negative != nil ) {
		
		alert->negativeButtonIndex = ( int )[ alert addButtonWithTitle:[ NSString stringWithUTF8String:negative ]];
	}
		
	[ alert show ];
#endif
	return 0;
}

//================================================================//
// MOAIDialogIOS
//================================================================//

//----------------------------------------------------------------//
MOAIDialogIOS::MOAIDialogIOS () {

	RTTI_SINGLE ( MOAILuaObject )
}

//----------------------------------------------------------------//
MOAIDialogIOS::~MOAIDialogIOS () {
}

//----------------------------------------------------------------//
void MOAIDialogIOS::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "DIALOG_RESULT_POSITIVE",	( u32 )DIALOG_RESULT_POSITIVE );
	state.SetField ( -1, "DIALOG_RESULT_NEUTRAL", 	( u32 )DIALOG_RESULT_NEUTRAL );
	state.SetField ( -1, "DIALOG_RESULT_NEGATIVE",	( u32 )DIALOG_RESULT_NEGATIVE );
	state.SetField ( -1, "DIALOG_RESULT_CANCEL", 	( u32 )DIALOG_RESULT_CANCEL );
	
	luaL_Reg regTable [] = {
		{ "showDialog",	_showDialog },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}