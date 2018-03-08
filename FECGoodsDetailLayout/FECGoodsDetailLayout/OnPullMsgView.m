//
//  OnPullMsgView.m
//  FECGoodsDetailLayout
//
//  Created by Qinz on 16/11/4.
//  Copyright © 2016年 FEC. All rights reserved.
//

#import "OnPullMsgView.h"

@implementation OnPullMsgView

+ (instancetype)onPullMsgView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"OnPullMsgView" owner:self options:nil] firstObject];
}

@end
