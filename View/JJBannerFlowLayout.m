//
//  JJBannerFlowLayout.m
//  banner
//
//  Created by lucy on 2017/4/18.
//  Copyright © 2017年 com.qunar.com. All rights reserved.
//

#import "JJBannerFlowLayout.h"

@implementation JJBannerFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}

@end




















