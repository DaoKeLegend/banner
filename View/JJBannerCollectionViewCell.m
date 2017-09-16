//
//  JJBannerCollectionViewCell.m
//  banner
//
//  Created by lucy on 2017/4/18.
//  Copyright © 2017年 com.qunar.com. All rights reserved.
//

#import "JJBannerCollectionViewCell.h"
#import "Masonry.h"

@interface JJBannerCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation JJBannerCollectionViewCell

#pragma mark - Override Base Function

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

}

#pragma mark - Object Base Function

- (void)setupUI
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:imageView];
    self.imageView = imageView;

}

#pragma mark - Getter & Setter Function

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    self.imageView.image = [UIImage imageNamed:@(indexPath.item).description];
}

@end
