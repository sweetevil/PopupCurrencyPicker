//
//  PopupCurrencyPicker.m
//
//  Created by Rajan Balana on 28/05/2013.
//  Copyright (c) 2013 Codeoi. All rights reserved.
//

#define __POPUP_CURRENCY_PICKER_DEFAULT_ANIMATION_DURATION 0.3

#import "PopupCurrencyPicker.h"

@implementation PopupCurrencyPicker (Private)


- (void) _didSelectDone
{
    if ([self.delegate respondsToSelector:@selector(popupCurrencyPicker:didSelectCurrency:)]) {
        [self.delegate popupCurrencyPicker:self didSelectCurrency:[self.currencyDictionary objectForKey:[self.countryArray objectAtIndex:[self.currencyPicker selectedRowInComponent:0]]]];
    }
    [self hide];
}

@end

@implementation PopupCurrencyPicker

@synthesize currencyPicker = _currencyPicker;
@synthesize doneButton = _doneButton;
@synthesize toolbar = _toolbar;
@synthesize animationDuration = _animationDuration;
@synthesize animationDelay = _animationDelay;
@synthesize delegate;

- (id)initWithFrame:(CGRect) parentFrame
{
    self = [super initWithFrame:parentFrame];
    if (self) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"CurrencyList" ofType:@"plist"];
        self.currencyDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:sourcePath];
        self.countryArray = [[self.currencyDictionary allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _shadowView = [[UIView alloc] initWithFrame:parentFrame];
        _shadowView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _shadowView.autoresizingMask = self.autoresizingMask;
        _animationDuration = __POPUP_CURRENCY_PICKER_DEFAULT_ANIMATION_DURATION;
        _currencyPicker = [[UIPickerView alloc] init];
        _currencyPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _currencyPicker.opaque = YES;
        _currencyPicker.delegate = self;
        _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_didSelectDone)];
        _currencyPicker.showsSelectionIndicator = YES;

        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, parentFrame.size.width, 44)];
        _toolbar.tintColor = [UIColor blackColor];
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _toolbar.items = [NSArray arrayWithObjects: flexibleSpace, _doneButton, nil];

        CGRect frame = CGRectMake(0, 0, parentFrame.size.width, _currencyPicker.frame.size.height + _toolbar.frame.size.height);

        _currencyView = [[UIView alloc] initWithFrame:frame];
        _currencyView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_currencyView addSubview:_toolbar];
        [_currencyView addSubview:_currencyPicker];
        frame = _currencyPicker.frame;
        frame.origin.y = _toolbar.frame.origin.y + _toolbar.frame.size.height;
        _currencyPicker.frame = frame;
        for (UIView * subview in _currencyPicker.subviews) {
            subview.frame = _currencyPicker.bounds;
        }
        _shadowView.alpha = 0.0;

        [self addSubview:_shadowView];
        [self addSubview:_currencyView];

        self.backgroundColor = [UIColor clearColor];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (id) init
{

    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    return [self initWithFrame:mainWindow.frame];
}

- (void) showFromView: (UIView *) parentView
{
    BOOL animated = _animationDuration > 0.0 ? YES : NO;
    self.frame = parentView.bounds;
    CGRect currencyViewFrame = _currencyView.frame;
    currencyViewFrame.origin.y = self.frame.size.height;
    _currencyView.frame = currencyViewFrame;
    currencyViewFrame.origin.y -= _currencyView.frame.size.height;

    [parentView endEditing:YES];
    [parentView addSubview:self];

    if([delegate respondsToSelector:@selector(popupCurrencyPickerWillShow:animated:)])
    {
        [delegate popupCurrencyPickerWillShow:self animated:animated];
    }
    [UIView animateWithDuration:_animationDuration
                          delay:_animationDelay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _currencyView.frame = currencyViewFrame;
         _shadowView.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         if([delegate respondsToSelector:@selector(popupCurrencyPickerDidShow:animated:)])
         {
             [delegate popupCurrencyPickerDidShow:self animated:animated];
         }
     }
     ];
}

- (void) hide
{
    BOOL animated = _animationDuration > 0.0 ? YES : NO;
    CGRect currencyViewFrame = _currencyView.frame;
    currencyViewFrame.origin.y = self.frame.size.height;

    if([delegate respondsToSelector:@selector(popupCurrencyPickerWillHide:animated:)])
    {
        [delegate popupCurrencyPickerWillHide:self animated:animated];
    }
    [UIView animateWithDuration:_animationDuration
                          delay:_animationDelay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _currencyView.frame = currencyViewFrame;
         _shadowView.alpha = 0.0;
     }
                     completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         if([delegate respondsToSelector:@selector(popupCurrencyPickerDidHide:animated:)])
         {
             [delegate popupCurrencyPickerDidHide:self animated:animated];
         }
     }
     ];
}

#pragma mark PickerView Delegate Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    
    return self.countryArray.count;
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    
    return [[self.currencyDictionary valueForKey:[self.countryArray objectAtIndex:row]] objectAtIndex:3];
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
}
- (void) setAnimationDuration:(float)animationDuration
{
    _animationDuration = animationDuration;
}

- (float) animationDuration
{
    return _animationDuration;
}

- (void) setAnimationDelay:(float)animationDelay
{
    _animationDelay = animationDelay;
}

- (float) animationDelay
{
    return _animationDelay;
}

- (void) orientationDidChange: (NSNotification *) notification
{

}

@end
