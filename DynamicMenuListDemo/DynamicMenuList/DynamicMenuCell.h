//
//  DynamicMenuCell.h
//  MADPMainRootMenu
//
//  Created by TZ on 2017/8/29.
//  Copyright © 2017年 TZ. All rights reserved.
//

#define kCellIdentifier_DynamicMenuCell @"DynamicMenuCell"
#import <UIKit/UIKit.h>

@interface DynamicMenuCell : UICollectionViewCell

@property(nonatomic, copy) void(^editBlock)(NSIndexPath *selectIndexPath);

@property(nonatomic, strong) NSIndexPath *selectIndexPath;

/**
 * array: 首页应用
 * menuListArray: 服务器获取的菜单
 * indexPath: cell索引
 * edit: 是否处于编辑状态
 */
- (void)setExitMenuData:(NSArray *)array menuList:(NSArray *)menuListArray indexPath:(NSIndexPath *)indexPath isEdit:(BOOL)edit;

@end
