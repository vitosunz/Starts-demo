//
//  ViewController.m
//  0905-首屏
//
//  Created by SUN on 05/09/2016.
//  Copyright © 2016 SUN. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "NewFeatureView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self showNewFeatureView];
    
}


-(void)showNewFeatureView{
    //创建自定义视图
    NewFeatureView *fv = [[NewFeatureView alloc]initWithFrame:self.view.bounds];
    //设置images,传入img数组
    fv.images = [self getNewFeatureImgs];
    //添加到自定义视图中
    [self.view addSubview:fv];
    
}


//返回image数组
-(NSArray*)getNewFeatureImgs{
    int count = 4;
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        //拼接名称
        NSString *name = [@"common_h" stringByAppendingFormat:@"%d",i+1 ];
        
        UIImage *img = [UIImage imageNamed:name];
        
        [mArray addObject:img];
    }
    
    return mArray;
}

-(void)setupUI{
    //主页图片
    UIImageView *uv= [[UIImageView alloc]init];
    
    uv.image = [UIImage imageNamed:@"cozy-control-car"];
    
    [self.view addSubview:uv];
    //比例大小
    uv.contentMode = UIViewContentModeScaleAspectFit;
    //与父类间距的约束
    [uv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 50, 50, 50));
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
