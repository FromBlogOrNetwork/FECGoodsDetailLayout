//
//  DownPullMsgView.m
//  FECGoodsDetailLayout
//
//  Created by Qinz on 16/11/7.
//  Copyright © 2016年 FEC. All rights reserved.
//

#import "DownPullMsgView.h"

@implementation DownPullMsgView

+ (instancetype)downPullMsgView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DownPullMsgView" owner:self options:nil] firstObject];
}

@end
