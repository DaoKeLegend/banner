//
//  JJBannerView.m
//  banner
//
//  Created by lucy on 2017/4/17.
//  Copyright © 2017年 com.qunar.com. All rights reserved.
//

#import "JJBannerView.h"
#import "JJBannerFlowLayout.h"
#import "Masonry.h"
#import "JJBannerCollectionViewCell.h"

#define kJJBannerViewSectionCount               (100)

@interface JJBannerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JJBannerView

static NSString * const cellIdentify = @"cellIdentify";

#pragma mark - Overide Base Function

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupCollectionView];
        [self setupPageControl];
        [self setupTimer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-40);
        make.centerX.equalTo(self);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [self.timer invalidate];
}

#pragma mark - Object Private Function

- (void)setupCollectionView
{
    JJBannerFlowLayout *flowLayout = [[JJBannerFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[JJBannerCollectionViewCell class] forCellWithReuseIdentifier:cellIdentify];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
}

- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;

}

- (void)setupTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

#pragma mark - Object Base Function

- (void)nextPage
{
    NSInteger page = self.pageControl.currentPage;
    NSIndexPath *scrollIndexPath = nil;
    // 如果是最后一张图片
    if (page == self.imageArr.count - 1) {
        scrollIndexPath = [NSIndexPath indexPathForItem:0 inSection:kJJBannerViewSectionCount/2 + 1];
    }
    else {
        scrollIndexPath = [NSIndexPath indexPathForItem:page + 1 inSection:kJJBannerViewSectionCount/2];
    }
    [self.collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource>

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    NSInteger sectionNum = page / self.imageArr.count;
    NSInteger itemNUm = page % self.imageArr.count;
    
    if (sectionNum == kJJBannerViewSectionCount/2) {
        return;
    }
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForItem:itemNUm inSection:kJJBannerViewSectionCount/2];
    [self.collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = (scrollView.contentOffset.x/scrollView.bounds.size.width) + 0.499;
    NSInteger pageNO = page % self.imageArr.count;
    self.pageControl.currentPage = pageNO;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  kJJBannerViewSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JJBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - Getter & Setter Function

- (void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.imageArr.count;
    [self layoutIfNeeded];
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForItem:0 inSection:kJJBannerViewSectionCount/2];
    [self.collectionView scrollToItemAtIndexPath:scrollIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

@end














