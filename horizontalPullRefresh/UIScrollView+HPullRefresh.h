//
//  UIScrollView+HPullRefresh.h
//  YXFC
//
//  Created by Chu Mohua on 12-12-29.
//  Copyright (c) 2012年 Chu Mohua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

typedef enum {
    HPullRefreshViewLeft = 1,
    HPullRefreshViewRight,
    HPullRefreshViewRefreshing
}HPullRefreshViewStatus;

typedef void (^actionHandler)(void);

@interface HPullRefreshView : UIView

@property(nonatomic ,strong)        UIImageView *jt;
@property(nonatomic ,assign) UIScrollView *scrollow;
@property(nonatomic ,strong) UILabel *textLable;
@property(nonatomic ,strong) UIActivityIndicatorView *activity;
@property(nonatomic ,assign) int status;
@property(nonatomic ,assign) int userDrapx;
@property(nonatomic ,copy) actionHandler ah;

@end




@interface UIScrollView (HPullRefresh){

}

@property(nonatomic,strong) HPullRefreshView *hprv;

-(void)addHPullRefresh:(void (^)(void))actionHandler;
-(void)stopLoading;
-(void)startLoading;

@end



