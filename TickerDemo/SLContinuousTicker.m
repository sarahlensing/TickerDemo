//
//  SLContinuousTicker.m
//  TickerDemo
//
//  Created by Sarah Lensing on 7/8/12.
//  Copyright (c) 2012 NYU. All rights reserved.
//

#import "SLContinuousTicker.h"

@implementation SLContinuousTicker

@synthesize position = _position;

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 150)] autorelease];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.adjustsFontSizeToFitWidth = YES;
    lbl.text = text;
    return lbl;
}

- (void)createTopTickers {    
    _tickerD = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerD.delegate = self;
//    _tickerD.frontBackgroundColor = [UIColor redColor];
//    _tickerD.backBackgroundColor = [UIColor redColor];
//    _tickerD.frontView = [self labelWithText:@"D"];
//    _tickerD.backView = [self labelWithText:@"D"];
    
    _tickerC = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerC.delegate = self;
//    _tickerC.frontBackgroundColor = [UIColor orangeColor];
//    _tickerC.backBackgroundColor = [UIColor orangeColor];
//    _tickerC.frontView = [self labelWithText:@"C"];
//    _tickerC.backView = [self labelWithText:@"C"];
    
    _tickerB = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerB.delegate = self;
//    _tickerB.frontBackgroundColor = [UIColor blueColor];
//    _tickerB.backBackgroundColor = [UIColor blueColor];
//    _tickerB.frontView = [self labelWithText:@"B"];
//    _tickerB.backView = [self labelWithText:@"B"];
    
    _tickerA = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerA.delegate = self;
//    _tickerA.frontBackgroundColor = [UIColor greenColor];
//    _tickerA.backBackgroundColor = [UIColor greenColor];
//    _tickerA.frontView = [self labelWithText:@"A"];
//    _tickerA.backView = [self labelWithText:@"A"];
    
    _topTickers = [[NSArray alloc] initWithObjects:_tickerA, _tickerB, _tickerC, _tickerD, nil];
}

- (void)createBottomTickers {    
    _tickerZ = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerZ.delegate = self;
    _tickerZ.anchorType = TickerViewAnchorTop;
//    _tickerZ.frontBackgroundColor = [UIColor redColor];
//    _tickerZ.backBackgroundColor = [UIColor redColor];
//    _tickerZ.frontView = [self labelWithText:@"Z"];
//    _tickerZ.backView = [self labelWithText:@"Z"];
    
    _tickerY = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerY.delegate = self;
    _tickerY.anchorType = TickerViewAnchorTop;
//    _tickerY.frontBackgroundColor = [UIColor orangeColor];
//    _tickerY.backBackgroundColor = [UIColor orangeColor];
//    _tickerY.frontView = [self labelWithText:@"Y"];
//    _tickerY.backView = [self labelWithText:@"Y"];
    
    _tickerX = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerX.delegate = self;
    _tickerX.anchorType = TickerViewAnchorTop;
//    _tickerX.frontBackgroundColor = [UIColor blueColor];
//    _tickerX.backBackgroundColor = [UIColor blueColor];
//    _tickerX.frontView = [self labelWithText:@"X"];
//    _tickerX.backView = [self labelWithText:@"X"];
    
    _tickerW = [[SLDoubleSideTicker alloc] initWithFrame:_frame superView:_view];
    _tickerW.delegate = self;
    _tickerW.anchorType = TickerViewAnchorTop;
//    _tickerW.frontBackgroundColor = [UIColor greenColor];
//    _tickerW.backBackgroundColor = [UIColor greenColor];
//    _tickerW.frontView = [self labelWithText:@"W"];
//    _tickerW.backView = [self labelWithText:@"W"];
    
    _bottomTickers = [[NSArray alloc] initWithObjects:_tickerW, _tickerX, _tickerY, _tickerZ, nil];
}


- (id)initWithFrame:(CGRect)frame superView:(UIView *)superview {
    self = [super init];
    if (self) {
        _frame = frame;
        _view = superview;
        [self createTopTickers];        
        [self createBottomTickers];
        
        _keyTopTicker = _tickerC;
        _keyBottomTicker = _tickerY;
    }
    return self;
}

- (void)dealloc {
    [_topTickers release];
    [_bottomTickers release];
    [super dealloc];
}

- (void)setPosition:(CGPoint)position {
    _tickerA.position = position;
    _tickerB.position = position;
    _tickerC.position = position;
    _tickerD.position = position;
    _tickerW.position = position;
    _tickerX.position = position;
    _tickerY.position = position;
    _tickerZ.position = position;
}

#pragma mark - SLDoubleSideTickerDelegate
- (void)ticker:(SLDoubleSideTicker *)ticker didUpdateRotationTransform:(CGFloat)y {
    [ticker bringToFront];        
}

-(void)tickerFlippedToFront:(SLDoubleSideTicker *)ticker {

}

-(void)tickerFlippedToBack:(SLDoubleSideTicker *)ticker {
    if (ticker == _keyTopTicker) { 
        SLDoubleSideTicker *tickerToAdjust = [self topTickerToAdjust];
        [tickerToAdjust reset];
        _keyTopTicker = [self nextKeyTopTicker];
    }        
    else if (ticker == _keyBottomTicker) { 
        SLDoubleSideTicker *tickerToAdjust = [self bottomTickerToAdjust];
        [tickerToAdjust reset];
        _keyBottomTicker = [self nextKeyBottomTicker];
    }        
}

- (SLDoubleSideTicker *)topTickerToAdjust {
    if (_keyTopTicker == _tickerA) {
        return _tickerC;
    }
    else if (_keyTopTicker == _tickerB) {
        return _tickerD;
    }
    else if (_keyTopTicker == _tickerC) {
        return _tickerA;
    }
    return _tickerB;
}

- (SLDoubleSideTicker *)nextTopTicker:(SLDoubleSideTicker *)ticker away:(int)numAway {
    int startingIndex = -1;
    if (ticker == _tickerA) {
        startingIndex = 0;
    }
    else if (ticker == _tickerB) {
        startingIndex = 1;
    }
    else if (ticker == _tickerC) {
        startingIndex = 2;
    } 
    else {
        startingIndex = 3;
    }
    int index = (startingIndex + numAway) % _topTickers.count;
    return [_topTickers objectAtIndex:index];
}

- (SLDoubleSideTicker *)nextKeyTopTicker {
    return [self nextTopTicker:_keyTopTicker away:1];
}

- (SLDoubleSideTicker *)bottomTickerToAdjust {
    if (_keyBottomTicker == _tickerW) {
        return _tickerY;
    }
    else if (_keyBottomTicker == _tickerX) {
        return _tickerZ;
    }
    else if (_keyBottomTicker == _tickerY) {
        return _tickerW;
    }
    return _tickerX;
}

- (SLDoubleSideTicker *)nextBottomTicker:(SLDoubleSideTicker *)ticker away:(int)numAway {
    int startingIndex = -1;
    if (ticker == _tickerW) {
        startingIndex = 0;
    }
    else if (ticker == _tickerX) {
        startingIndex = 1;
    }
    else if (_keyBottomTicker == _tickerY) {
        startingIndex = 2;
    }
    else {
        startingIndex = 3;
    }
    int index = (startingIndex + numAway) % _bottomTickers.count;
    return [_bottomTickers objectAtIndex:index];
}

- (SLDoubleSideTicker *)nextKeyBottomTicker {
    return [self nextBottomTicker:_keyBottomTicker away:1];
}

@end
