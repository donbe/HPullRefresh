//
//  UIScrollView+HPullRefresh.m
//  YXFC
//
//  Created by Chu Mohua on 12-12-29.
//  Copyright (c) 2012年 Chu Mohua. All rights reserved.
//

#import "UIScrollView+HPullRefresh.h"

static char KeyHPullRefreshView;

@implementation HPullRefreshView{
    
}

-(id)init{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 100, 80);
        self.jt = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pull_right.png"]];
        [self.jt setFrame:CGRectMake(20, 12, 46, 32)];
        [self addSubview:self.jt];
        
        self.textLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.bounds.size.width-10, 40)];
        self.textLable.text = @"右拉刷新...";
        self.textLable.font=[UIFont boldSystemFontOfSize:13];
        self.textLable.textColor = [UIColor colorWithWhite:0.733 alpha:1.000];
        self.textLable.backgroundColor = [UIColor clearColor];
        self.textLable.textAlignment = UITextAlignmentCenter;
        self.textLable.numberOfLines = 0;
        self.textLable.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.textLable];
        
        self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(40, 30, 20, 20)];
        self.activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:self.activity];
    }
    return self;
}


- (void)rotateArrow:(float)degrees hide:(BOOL)hide {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.jt.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
        self.jt.layer.opacity = !hide;
    } completion:NULL];
}
-(void)layoutSubviews{

}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollow.contentInset = contentInset;
                     }
                     completion:NULL];
}
@end


@implementation UIScrollView (HPullRefresh)

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setHprv:(HPullRefreshView *)hprv{
    [self willChangeValueForKey:@"HPullRefreshView"];
    objc_setAssociatedObject(self, &KeyHPullRefreshView,
                             hprv,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"HPullRefreshView"];
}

-(HPullRefreshView *)hprv{
    return objc_getAssociatedObject(self, &KeyHPullRefreshView);
}

-(void)addHPullRefresh:(actionHandler)actionHandler{
    //添加剪头
    self.hprv = [[HPullRefreshView alloc] init];
    [self.hprv setFrame:CGRectMake(-(self.hprv.bounds.size.width), (self.bounds.size.height-self.hprv.bounds.size.height)/2, self.hprv.bounds.size.width, self.hprv.bounds.size.height)];
    self.hprv.scrollow = self;
    [self addSubview:self.hprv];
    
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.hprv.ah = actionHandler;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]){
        if (self.contentOffset.x >=0) {

        }else {

            if (self.hprv.status !=HPullRefreshViewRefreshing) {
                if (self.isDragging) {
                    self.hprv.userDrapx = self.contentOffset.x;
                    if (self.contentOffset.x < -100) {
                        self.hprv.textLable.text = @"Release to refresh...";
                        [self.hprv rotateArrow:M_PI hide:NO];
                        self.hprv.status = HPullRefreshViewLeft;
                    }else{
                        [self.hprv rotateArrow:0 hide:NO];
                        self.hprv.textLable.text = @"Pull to refresh...";
                        self.hprv.status = HPullRefreshViewRight;
                    }
                }else{
                    if(self.contentOffset.x < -85 && self.hprv.status == HPullRefreshViewLeft) {
                        //开始loading
                        self.hprv.status = HPullRefreshViewRefreshing;
                        self.hprv.textLable.text = @"Loading...";
                        [self.hprv setScrollViewContentInset:UIEdgeInsetsMake(0, 85, 0, 0)];
                        [self.hprv rotateArrow:0 hide:YES];
                        [self.hprv.activity startAnimating];
                        self.hprv.ah();
                    }
                }
            }
        }
    }
}

-(void)stopLoading{
    self.hprv.textLable.text = @"Pull to refresh...";
    [self.hprv.activity stopAnimating];
    self.hprv.status = HPullRefreshViewRight;
    [self.hprv setScrollViewContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    if (self.hprv.userDrapx) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

-(void)startLoading{
    if (self.hprv.status !=HPullRefreshViewRefreshing) {
        self.hprv.status = HPullRefreshViewLeft;
        [self.hprv setScrollViewContentInset:UIEdgeInsetsMake(0, 100, 0, 0)];
        [self setContentOffset:CGPointMake(-100, 0) animated:YES];
    }
}
@end
