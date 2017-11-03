//
//  DynamicMenuCell.m
//  MADPMainRootMenu
//
//  Created by TZ on 2017/8/29.
//  Copyright © 2017年 TZ. All rights reserved.
//

#import "DynamicMenuCell.h"

@interface DynamicMenuCell ()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *editBtn;

@property(nonatomic, strong) CALayer *rightLine, *bottomLine;
@end

@implementation DynamicMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        if (!_imageView) {
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kMenuListItemHeight - 30*SCALE)/2, 15*SCALE, 30*SCALE, 30*SCALE)];
            [self.contentView addSubview:_imageView];
        }
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom + 10, kMenuListItemHeight, 20)];
            _titleLabel.font = [UIFont systemFontOfSize:14];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_titleLabel];
        }
        if (!_editBtn) {
            _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _editBtn.frame = CGRectMake(kMenuListItemHeight - 18*SCALE, 0, 18*SCALE, 18*SCALE);
            _editBtn.layer.cornerRadius = _editBtn.width/2;
            _editBtn.layer.masksToBounds = YES;
            _editBtn.hidden = YES;
            [_editBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_editBtn];
        }
    }
    return self;
}

- (void)setExitMenuData:(NSArray *)array menuList:(NSArray *)menuListArray indexPath:(NSIndexPath *)indexPath isEdit:(BOOL)edit {
    self.selectIndexPath = indexPath;
    
    if (indexPath.row != 3) {
        if (!_rightLine) {
            _rightLine = [CALayer layer];
            _rightLine.frame = CGRectMake(kMenuListItemHeight - kSeparatorLineHeight, 0, kSeparatorLineHeight, kMenuListItemHeight - kSeparatorLineHeight);
            _rightLine.backgroundColor = kSeparatorLineColor.CGColor;
            [self.contentView.layer addSublayer:_rightLine];
        }
    }
    if (!_bottomLine) {
        _bottomLine = [CALayer layer];
        _bottomLine.frame = CGRectMake(0, kMenuListItemHeight - kSeparatorLineHeight, kMenuListItemHeight, kSeparatorLineHeight);
        _bottomLine.backgroundColor = kSeparatorLineColor.CGColor;
        [self.contentView.layer addSublayer:_bottomLine];
    }
    
    NSDictionary *curDic;
    if (indexPath.section == 0) {
        if (indexPath.row < array.count) {
            curDic = array[indexPath.row];
        }
    } else {
        if (indexPath.row < menuListArray.count) {
            curDic = menuListArray[indexPath.row];
        }
    }
    if ((indexPath.section == 0 && indexPath.row < array.count) || (indexPath.section > 0 && indexPath.row < menuListArray.count)) {
        [self hiddenCellContent:NO];
        _imageView.image = [UIImage imageNamed:[curDic objectForKey:@"image"]];
        _titleLabel.text = [curDic objectForKey:@"actionName"];
    } else {
        [self hiddenCellContent:YES];
    }
    
    if (edit) {
        if ((indexPath.section == 0 && indexPath.row < array.count) || (indexPath.section > 0 && indexPath.row < menuListArray.count)) {
            self.editBtn.hidden = NO;
        } else {
            self.editBtn.hidden = YES;
        }
        if (indexPath.section == 0) {
            self.editBtn.userInteractionEnabled = YES;
            [self.editBtn setBackgroundImage:[UIImage imageNamed:@"life_reduce"] forState:UIControlStateNormal];
        } else {
            if ([array containsObject:curDic]) {
                self.editBtn.userInteractionEnabled = NO;
                [self.editBtn setBackgroundImage:[UIImage imageNamed:@"life_exist"] forState:UIControlStateNormal];
            } else {
                self.editBtn.userInteractionEnabled = YES;
                [self.editBtn setBackgroundImage:[UIImage imageNamed:@"life_add"] forState:UIControlStateNormal];
            }
        }
    } else {
        self.editBtn.hidden = YES;
    }
}

- (void)editClick {
    if (self.editBlock) {
        self.editBlock(self.selectIndexPath);
    }
}

- (void)hiddenCellContent:(BOOL)hidden {
    self.imageView.hidden = hidden;
    self.titleLabel.hidden = hidden;
}

@end
