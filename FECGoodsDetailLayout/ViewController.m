//
//  ViewController.m
//  FECGoodsDetailLayout
//
//  Created by Qinz on 16/11/4.
//  Copyright © 2016年 FEC. All rights reserved.


#import "ViewController.h"
#import "FECGoodsDetailLayout.h"
#import "DetailCell.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化实例
    FECGoodsDetailLayout*detailView = [[FECGoodsDetailLayout alloc]init];

   
    //调用方法
    [detailView setGoodsDetailLayout:self WebViewURL:@"https://www.baidu.com" IsConverAnimation:YES bottomHeighr:self.bottomView.frame.size.height];
    
    //滚动监听
    detailView.scrollScreenBlock = ^(BOOL isFirst){
        if (isFirst) {
             NSLog(@"滚动到了第一屏");
        }else{
            NSLog(@"第二屏");
        }
    };
}





@end
