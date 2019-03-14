//
//  UIView+Constraints.m
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (Constraints)

- (void)addConstraintsWithVisualFormat:(NSString *)format withViews:(UIView *)views,... {
    NSMutableDictionary *viewDictionary = [[NSMutableDictionary alloc] init];
    
    UIView *eachObject;
    va_list argumentList;
    if(views){
        int idx = 0;
        views.translatesAutoresizingMaskIntoConstraints = NO;
        [viewDictionary setObject:views forKey:[NSString stringWithFormat:@"v%d", idx]];
        va_start(argumentList, views);
        while ((eachObject = va_arg(argumentList, UIView *))) {
            idx++;
            eachObject.translatesAutoresizingMaskIntoConstraints = NO;
            [viewDictionary setObject:eachObject forKey:[NSString stringWithFormat:@"v%d", idx]];
        }
        va_end(argumentList);
    }
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewDictionary]];
}

@end
