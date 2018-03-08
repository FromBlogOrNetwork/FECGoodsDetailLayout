//
//  TableHeaderView.m
//  FECGoodsDetailLayout
//
//  Created by Qinz on 16/11/4.
//  Copyright © 2016年 FEC. All rights reserved.
//

#import "TableHeaderView.h"

@implementation TableHeaderView

+ (instancetype)tableHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil] firstObject];
}

@end
