//
//  DynamicMenuListViewController.h
//  MADPMainRootMenu
//
//  Created by TZ on 2017/8/29.
//  Copyright © 2017年 TZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicMenuListViewController : UIViewController

@property(nonatomic, strong) NSArray *dataList;

@property(nonatomic, copy) void(^refreshMenuListBlock)();

@end
