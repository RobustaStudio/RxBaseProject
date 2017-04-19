//
//  UITableView+EmptyData.m
//  Pods
//
//  Created by Ahmed Mohamed Fareed on 4/17/17.
//
//

#import "UITableView+EmptyData.h"

#import <objc/runtime.h>

@implementation UITableView (EmptyData)
// Swizzling is necessary to workaround http://www.openradar.me/21137690
+ (void)load
{
    NSLog(@"this is superf test");

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(initWithCoder:);
        SEL swizzledSelector = @selector(xxx_initWithCoder:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        
        originalSelector = @selector(initWithFrame:);
        swizzledSelector = @selector(xxx_initWithFrame:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}


- (nullable instancetype)xxx_initWithCoder:(NSCoder *)aDecoder  {
    [self xxx_initWithCoder:aDecoder];
    if ([self respondsToSelector:NSSelectorFromString(@"configureRx")]) {
        SEL selector = NSSelectorFromString(@"configureRx");
        ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
    }
    return self;
}

- (instancetype)xxx_initWithFrame:(CGRect)frame style:(UITableViewStyle)style  {
    [self xxx_initWithFrame:frame style:style];
    if ([self respondsToSelector:NSSelectorFromString(@"configureRx")]) {
        SEL selector = NSSelectorFromString(@"configureRx");
        ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
    }
    return self;
}

@end
