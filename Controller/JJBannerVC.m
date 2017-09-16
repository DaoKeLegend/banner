//
//  JJBannerVC.m
//  banner
//
//  Created by lucy on 2017/4/17.
//  Copyright © 2017年 com.qunar.com. All rights reserved.
//

#import "JJBannerVC.h"
#import "JJBannerView.h"
#import "Masonry.h"

@interface JJBannerVC ()

@property (nonatomic, strong) JJBannerView *bannerView;


@end

@implementation JJBannerVC

#pragma mark - Override Base Function

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bannerView = [[JJBannerView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.bannerView];
    
    self.bannerView.imageArr = [self loadImageArr];
    
}

- (void)viewWillLayoutSubviews
{
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

#pragma mark - Object Private Function

- (NSArray *)loadImageArr
{
    NSMutableArray *imageArrM = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i ++) {
        NSString *imageStr = [NSString stringWithFormat:@"Home_Scroll_%02zd",i+1];
        UIImage *image = [UIImage imageNamed:imageStr];
        [imageArrM addObject:image];
    }
    return imageArrM.copy;
}

@end
