//
//  NewFeatureView.m
//  0905-首屏
//
//  Created by SUN on 05/09/2016.
//  Copyright © 2016 SUN. All rights reserved.
//

#import "NewFeatureView.h"
#import "Masonry.h"
//声明UIScrollView的代理(监控滚动等动作时时触发的方法(开始,结束,缩放))
@interface NewFeatureView () <UIScrollViewDelegate>

@property (nonatomic , weak) UIScrollView* sv;
@property (nonatomic , weak) UIPageControl *pc;

@end

@implementation NewFeatureView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setImages:(NSArray*)images
{
    _images = images;

    CGRect rect = self.sv.bounds;
    CGFloat width = rect.size.width;
    for (int i = 0; i < images.count; i++) {

        UIImageView* iv = [[UIImageView alloc] initWithFrame:self.sv.bounds];

        iv.frame = CGRectOffset(rect, width * i, 0);
        //拉伸全屏
        iv.contentMode = UIViewContentModeScaleToFill;
        iv.image = images[i];
        //开启交互
        iv.userInteractionEnabled = YES;
        
        UIButton *btn = [self createMoreBtn];
        [iv addSubview:btn];
        //点击事件
        [btn addTarget:self action:@selector(clickMoreBtn:) forControlEvents:UIControlEventTouchDown];
        
        //btn布局
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            //底部和右部偏移
            make.bottom.right.mas_equalTo(iv).offset(-50);
            //大小
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        
        
        [_sv addSubview:iv];
    }

    //最后一页
    self.sv.contentSize = CGSizeMake((images.count + 1) * width + 1, 0);
    
    _pc.numberOfPages = images.count;
}

-(void)clickMoreBtn:(UIButton *)sender{
    //btn的父类(UIImageView)
    UIView *view = sender.superview;
    //动画
    [UIView animateWithDuration:1.2 animations:^{
        //放大
        view.transform = CGAffineTransformMakeScale(2.0, 2.0);
        //View透明
        view.alpha = 0;
        //按钮透明
        _pc.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (UIButton *)createMoreBtn{
    
        UIButton* btn = [[UIButton alloc] init];
        //btn状态(无用)
        [btn setImage:[UIImage imageNamed:@"common_more_black"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"common_more_white"] forState:UIControlStateHighlighted];
        return btn;
    
}


//滚动时的方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //判断滚动到第n页,当前x/sv宽度,加上0.5则为在中点是改变,不加则在边界改变当前页码
    int page = (scrollView.contentOffset.x/scrollView.bounds.size.width)+0.65;
    
    _pc.currentPage = page;
    
    _pc.hidden = (page == _pc.numberOfPages);
    
    //若滚动到最后则销毁视图
    if(scrollView.contentOffset.x == scrollView.bounds.size.width*_images.count){
        NSLog(@"over");
        [self removeFromSuperview];
    }
}


- (void)setupUI
{
    
    
    //创建ScrollView
    //**Start**
    UIScrollView* sv = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:sv];

    //垂直滚动条
    sv.showsVerticalScrollIndicator = NO;
    //水平滚动条
    sv.showsHorizontalScrollIndicator = NO;
    //边界反弹
    sv.bounces = NO;
    //分页
    sv.pagingEnabled = YES;
    
    //**设置当前视图为scrollView的代理**
    sv.delegate = self;
    
    _sv = sv;
    //**End**
    
    //创建UIPageControl  **Start**
    
    UIPageControl *pc = [[UIPageControl alloc]init];
//    pc.numberOfPages = 5;
//    pc.currentPage = 0;
    
    //未选中按钮颜色
    pc.pageIndicatorTintColor = [UIColor colorWithRed:0.17 green:0.17 blue:0.17 alpha:1.00];
    //选中颜色
    pc.currentPageIndicatorTintColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    //不允许交互
    pc.userInteractionEnabled = NO;
    [self addSubview:pc];
    //约束,参考中心点,像下偏移100
    [pc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-100);
    }];
    
    _pc = pc;
    //**End**

    
}

@end
