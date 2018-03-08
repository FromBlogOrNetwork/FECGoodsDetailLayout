//
//  DetailCell.m
//  FECGoodsDetailLayout
//
//  Created by Qinz on 16/11/4.
//  Copyright © 2016年 FEC. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

+ (instancetype) detailCell:(UITableView *) tableView{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
 
}



@end
