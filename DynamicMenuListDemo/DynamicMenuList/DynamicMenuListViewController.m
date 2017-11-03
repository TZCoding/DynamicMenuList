//
//  DynamicMenuListViewController.m
//  MADPMainRootMenu
//
//  Created by TZ on 2017/8/29.
//  Copyright © 2017年 TZ. All rights reserved.
//

#import "DynamicMenuListViewController.h"
#import "DynamicMenuHeaderView.h"
#import "DynamicMenuFooterView.h"
#import "DynamicMenuCell.h"

@interface DynamicMenuListViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *myCollectionView;

@property(nonatomic, assign) BOOL inEditState; // 是否处于编辑状态
@property(nonatomic, strong) NSMutableArray *exitItemArray;
@property(nonatomic, strong) UILabel *tipLabel;
@end

@implementation DynamicMenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"全部应用";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editMenuClick:)];
    self.exitItemArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) collectionViewLayout:layout];
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    _myCollectionView.backgroundColor = kTableViewBgColor;
    [_myCollectionView registerClass:[DynamicMenuCell class] forCellWithReuseIdentifier:kCellIdentifier_DynamicMenuCell];
    [_myCollectionView registerClass:[DynamicMenuHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDynamicMenuHeaderView];
    [_myCollectionView registerClass:[DynamicMenuFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kDynamicMenuFooterView];
    [self.view addSubview:_myCollectionView];
}

#pragma mark - collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataList.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger addCount = (self.exitItemArray.count % 4 == 0 ? 0 : (4 - self.exitItemArray.count % 4));
        return self.exitItemArray.count + addCount;
    } else {
        NSArray *list = [self.dataList objectAtIndex:(section - 1)][@"menuList"];
        NSInteger surplusCount = (list.count % 4 == 0 ? 0 : (4 - list.count % 4)); // 填充剩余空格
        return list.count + surplusCount;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_DynamicMenuCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        
    }
    NSArray *menuList = indexPath.section == 0 ? nil : [self.dataList objectAtIndex:(indexPath.section - 1)][@"menuList"];
    [cell setExitMenuData:self.exitItemArray menuList:menuList indexPath:indexPath isEdit:self.inEditState];
    
    __weak typeof(self) weakSelf = self;
    cell.editBlock = ^(NSIndexPath *selectIndexPath) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (indexPath.section == 0) { // 移除
            [strongSelf.exitItemArray removeObjectAtIndex:selectIndexPath.row];
            [self.myCollectionView reloadData];
        } else { // 添加
            if (strongSelf.exitItemArray.count == 11) {
                kTipAlert(@"首页最多添加11个应用！");
            } else {
                NSArray *menuList = [self.dataList objectAtIndex:(selectIndexPath.section - 1)][@"menuList"];
                [strongSelf.exitItemArray addObject:menuList[indexPath.row]];
                [strongSelf.myCollectionView reloadData];
            }
        }
    };
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        DynamicMenuHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDynamicMenuHeaderView forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headView.headLabel.text = @"首页应用";
        } else {
            headView.headLabel.text = self.dataList[(indexPath.section - 1)][@"title"];
        }
        return headView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        DynamicMenuFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kDynamicMenuFooterView forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kMenuListItemHeight, kMenuListItemHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.exitItemArray.count == 0) {
        if (section == 0) {
            self.tipLabel.frame = CGRectMake(0, 40, kScreen_Width, kMenuListItemHeight);
            [self.myCollectionView addSubview:self.tipLabel];
            return CGSizeMake(kScreen_Width, kMenuListItemHeight + 40);
        } else {
            return CGSizeMake(kScreen_Width, 40);
        }
    } else {
        [self.tipLabel removeFromSuperview];
        return CGSizeMake(kScreen_Width, 40);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return section == self.dataList.count ? CGSizeZero : CGSizeMake(kScreen_Width, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.inEditState) {
        NSArray *menuList;
        if (indexPath.section == 0) {
            menuList = self.exitItemArray;
        } else {
            menuList = [self.dataList objectAtIndex:(indexPath.section - 1)][@"menuList"];
        }
        if (indexPath.row < menuList.count) {
            
        }
    }
}

#pragma mark - getter/setter

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.numberOfLines = 0;
        _tipLabel.backgroundColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"您还未添加任何应用\n请点击编辑添加";
    }
    return _tipLabel;
}

#pragma mark - action

- (void)editMenuClick:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        self.inEditState = YES;
        self.myCollectionView.allowsSelection = NO;
        
    } else if ([item.title isEqualToString:@"完成"]) {
        item.title = @"编辑";
        self.inEditState = NO;
        self.myCollectionView.allowsSelection = YES;
    }
    [self.myCollectionView reloadData];
}

@end
