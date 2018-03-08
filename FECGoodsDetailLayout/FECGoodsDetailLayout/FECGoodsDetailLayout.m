//
//  FECGoodsDetailLayout.m
//  FECGoodsDetailLayout
//
//  Created by Qinz on 16/11/4.
//  Copyright © 2016年 FEC. All rights reserved.
//

#import "FECGoodsDetailLayout.h"


@interface FECGoodsDetailLayout ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIWebView *webView;

//添加在头部视图的tempScrollView
@property (nonatomic, strong) UIScrollView *tempScrollView;
//记录是否需要滚动视图差效果的动画
@property (nonatomic, assign) BOOL isConverAnimation;
//记录底部空间所需的高度
@property (nonatomic, assign) CGFloat bottomHeight;

@end

@implementation FECGoodsDetailLayout

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


-(void)setGoodsDetailLayout:(UIViewController*)viewController WebViewURL:(NSString*)webViewURL IsConverAnimation:(BOOL)isConverAnimation bottomHeighr:(CGFloat)bottomHeight{
    
    [self layout:bottomHeight];
    
    //设置上下拉提示的视图
    [self setMsgView];
    
    [viewController.view addSubview:self];
    
    //将视图要置为最底层
    [viewController.view sendSubviewToBack:self];
    
    _isConverAnimation = isConverAnimation;
    // 加载图文详情
    WS(b_self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [b_self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webViewURL]]];
    });
}


-(void)layout:(CGFloat)bottomHeight{

    
    self.bottomHeight = bottomHeight;
    
    self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT- bottomHeight);
    self.backgroundColor = [UIColor whiteColor];
    
    self.bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, (kSCREEN_HEIGHT-bottomHeight)*2)];
    self.bigView.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT- bottomHeight)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-bottomHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - bottomHeight)];
    _webView.backgroundColor = [UIColor clearColor];
    
    self.webView.scrollView.delegate = self;
    
    [self addSubview:_bigView];
    [_bigView addSubview:_tableView];
    [_bigView addSubview:_webView];

}


-(void)setMsgView{
    
    //添加头部和尾部视图
    UIView*headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH)];
    headerView.backgroundColor = [UIColor blueColor];
    _tempScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH)];
    [headerView addSubview:_tempScrollView];
    TableHeaderView*tableHeaderView = [TableHeaderView tableHeaderView];
    tableHeaderView.frame = headerView.frame;
    [_tempScrollView addSubview:tableHeaderView];
    _tableView.tableHeaderView = headerView;
    OnPullMsgView*pullMsgView = [OnPullMsgView onPullMsgView];
    UIView*footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, KmsgVIewHeight)];
    pullMsgView.frame = footView.bounds;
    [footView addSubview:pullMsgView];
    _tableView.tableFooterView = footView;
    //设置下拉提示视图
    DownPullMsgView*downPullMsgView = [DownPullMsgView downPullMsgView];
    UIView*downMsgView = [[UIView alloc]initWithFrame:CGRectMake(0, -KmsgVIewHeight, kSCREEN_WIDTH, KmsgVIewHeight)];
    downPullMsgView.frame = downMsgView.bounds;
    [downMsgView addSubview:downPullMsgView];
    [_webView.scrollView addSubview:downMsgView];
}

#pragma mark -- UIScrollViewDelegate 用于控制头部视图滑动的视差效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isConverAnimation) {
        CGFloat offset = scrollView.contentOffset.y;
        if (scrollView == _tableView){
            //重新赋值，就不会有用力拖拽时的回弹
            _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, 0);
            if (offset >= 0 && offset <= kSCREEN_WIDTH) {
                //因为tempScrollView是放在tableView上的，tableView向上速度为1，实际上tempScrollView的速度也是1，此处往反方向走1/2的速度，相当于tableView还是正向在走1/2，这样就形成了视觉差！
                _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, - offset / 2.0f);
            }
        }
    }else{}
}

#pragma mark -- 监听滚动实现商品详情与图文详情界面的切换
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    WS(b_self);
    
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == _tableView) {
        if (offset > _tableView.contentSize.height - kSCREEN_HEIGHT + self.bottomHeight + KendDragHeight) {
            [UIView animateWithDuration:0.4 animations:^{
                b_self.bigView.transform = CGAffineTransformTranslate(b_self.bigView.transform, 0, -kSCREEN_HEIGHT +  self.bottomHeight + KnavHeight);
            } completion:^(BOOL finished) {
                if (b_self.scrollScreenBlock) {
                    b_self.scrollScreenBlock(NO);
                }
                
            }];
        }
    }
    if (scrollView == _webView.scrollView) {
        if (offset < - KendDragHeight) {
            [UIView animateWithDuration:0.4 animations:^{
                [UIView animateWithDuration:0.4 animations:^{
                    b_self.bigView.transform = CGAffineTransformIdentity;
                    
                }];
            } completion:^(BOOL finished) {
                if (b_self.scrollScreenBlock) {
                    b_self.scrollScreenBlock(YES);
                }
            }];
        }
    }
}



///*******************下面TableView的代理是需要自行实现*********************

#pragma mark -- 每组返回多少个 需要根据实际情况设置！！！

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark -- 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark -- 每个cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailCell *cell = [DetailCell detailCell:tableView];
    return cell;
    
}


#pragma mark -- 每组头部视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}


#pragma mark -- 选择每个cell执行的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
