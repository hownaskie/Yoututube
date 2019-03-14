//
//  Setting.m
//  Yoututube
//
//  Created by JonasC on 14/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "Setting.h"

@implementation Setting

- (instancetype)initWithName:(NSString *)name withImageName:(NSString *)imageName {
    self = [super init];
    self.name = name;
    self.imageName = imageName;
    return self;
}

@end
