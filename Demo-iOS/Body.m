//
//  Body.m
//  Demo-iOS
//
//  Created by Luiz on 13.02.18.
//  Copyright © 2018 smoca. All rights reserved.
//

#import "Body.h"

@implementation Body

- (instancetype)initWithWeight:(NSInteger)weight andHeight:(NSInteger)height {
    self.weight = weight;
    self.height = height;
    return self;
}

- (NSInteger) getBmi {
    double heightInM = (double) self.height / 100;
    double bmi = self.weight / (heightInM * heightInM);
    
    return (NSInteger) round(bmi);
}

@end
