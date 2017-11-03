//
//  DynamicMenuHeaderView.h
//  MADPMainRootMenu
//
//  Created by TZ on 2017/8/29.
//  Copyright © 2017年 TZ. All rights reserved.
//

#define kDynamicMenuHeaderView @"DynamicMenuHeaderView"
#import <UIKit/UIKit.h>

@interface DynamicMenuHeaderView : UICollectionReusableView

@property(nonatomic, strong) UILabel *headLabel;

@property(nonatomic, strong) NSIndexPath *curIndexPath;

@end
