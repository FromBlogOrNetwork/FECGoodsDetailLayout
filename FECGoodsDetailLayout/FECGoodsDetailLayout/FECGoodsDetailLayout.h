//
//  FECGoodsDetailLayout.h
//  FECGoodsDetailLayout
//
//  Created by Qinz on 16/11/4.
//  Copyright © 2016年 FEC. All rights reserved.

/*
 
 使用说明：1、TableHeaderView为tableView表头视图,在xib中根据实际情况自定义
         2、DetailCell为tableView的item,在xib中根据实际情况自定义
         1、OnPullMsgView为上拉加载图文详情视图，在xib中根据实际情况自定义
         1、DownPullMsgView为下拉显示商品详情视图，在xib中根据实际情况自定义
 
 注意：在.m文件中自行实现tableView的代理方法代码，因为此处涉及到滚动监听，难以将代理传入给控制器！
 */

#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WS(b_self)  __weak __typeof(&*self)b_self = self;

//拖拽的高度
#define KendDragHeight 50.0
//导航栏的高度
#define KnavHeight 64.0
//提示上下拉视图的高度
#define KmsgVIewHeight 40.0

#import <UIKit/UIKit.h>

#import "TableHeaderView.h"
#import "DetailCell.h"
#import "OnPullMsgView.h"
#import "DownPullMsgView.h"

typedef void(^ScrollScreenBlock)(BOOL isFirst);

@interface FECGoodsDetailLayout : UIView

/**
 实例方法

 @param viewController    传入当前控制器
 @param webViewURL        图文详情的html地址
 @param isConverAnimation 是否需要滚动视图差动画
 @param bottomHeight 底部视图需要的高度--放置“立即购买的”位置
 */
-(void)setGoodsDetailLayout:(UIViewController*)viewController WebViewURL:(NSString*)webViewURL IsConverAnimation:(BOOL)isConverAnimation bottomHeighr:(CGFloat)bottomHeight;

//滚动监听Block:为YES是滚动到了商品详情 NO滚动到图文详情
@property (nonatomic, copy) ScrollScreenBlock scrollScreenBlock;


@end
