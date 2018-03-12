//
//  Body.h
//  Demo-iOS
//
//  Created by Luiz on 13.02.18.
//  Copyright © 2018 smoca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Body : NSObject

@property NSInteger weight;
@property NSInteger height;

- (instancetype)initWithWeight:(NSInteger)weight andHeight:(NSInteger)height;
- (NSInteger) getBmi;
@end
