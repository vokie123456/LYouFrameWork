//
//  HXCountDownButotn.h
//  HXTG
//
//  Created by grx on 2017/2/24.
//  Copyright © 2017年 grx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYCountDownButton;

typedef NSString* (^DidChangeBlock)(LYCountDownButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(LYCountDownButton *countDownButton,int second);
typedef void (^TouchedDownBlock)(LYCountDownButton *countDownButton,NSInteger tag);

@interface LYCountDownButton : UIButton{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}


-(void)addToucheHandler:(TouchedDownBlock)touchHandler;
-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;

@end
