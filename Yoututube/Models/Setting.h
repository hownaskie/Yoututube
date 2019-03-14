//
//  Setting.h
//  Yoututube
//
//  Created by JonasC on 14/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Setting : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageName;

- (instancetype)initWithName:(NSString *)name withImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
