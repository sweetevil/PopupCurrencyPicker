//
//  PopupCurrencyPickerDelegate.h
//
//  Created by Rajan Balana on 28/05/2013.
//  Copyright (c) 2013 Codeoi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PopupCurrencyPicker;

/// Protocol to define methods invoked on a PopupCurrencyPickerDelegate when it's displayed
/// or hidden and when a new currency is selected.
///
@protocol PopupCurrencyPickerDelegate <NSObject>

@optional

/// Invoked before the currency picker is shown.
///
/// @param currencyPicker
///     The currencyPicker that will be shown.
///
/// @param animated
///     Indicates whether or not the transition will be animated.
///
- (void)popupCurrencyPickerWillShow:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated;

/// Invoked after the currency picker is shown.
///
/// @param currencyPicker
///     The currencyPicker that was shown.
///
/// @param animated
///     Indicates whether or not the transition was animated.
///
- (void)popupCurrencyPickerDidShow:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated;

/// Invoked before the currency picker is hidden.
///
/// @param currencyPicker
///     The currencyPicker that will be hidden.
///
/// @param animated
///     Indicates whether or not the transition will be animated.
///
- (void)popupCurrencyPickerWillHide:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated;

/// Invoked after the currency picker is hidden.
///
/// @param currencyPicker
///     The currencyPicker that was hidden.
///
/// @param animated
///     Indicates whether or not the transition was animated.
///
- (void)popupCurrencyPickerDidHide:(PopupCurrencyPicker *)currencyPicker animated:(BOOL)animated;

/// Invoked when a new currency is selected.
///
/// @param currencyPicker
///     The currencyPicker.
///
/// @param currencyArray
///     The array for currency that was selected.
///
- (void)popupCurrencyPicker:(PopupCurrencyPicker *)currencyPicker didSelectCurrency:(NSArray *)currencyArray;

@end

