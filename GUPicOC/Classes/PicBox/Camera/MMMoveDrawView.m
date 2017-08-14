//
//  MMMoveDrawView.m
//  CircleAnimation
//
//  Created by 王腾飞 on size17/4/22.
//  Copyright © size17年 王腾飞. All rights reserved.
//

#import "MMMoveDrawView.h"


static CGPoint pointOne;
static CGPoint pointTwo;
static CGPoint pointThree;
static CGPoint pointFour;

static CGFloat size = 20;

@interface MMMoveDrawView ()
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@property (nonatomic, strong)CAShapeLayer *fillLayer;
@property (nonatomic, strong)UIView *dotOne;
@property (nonatomic, strong)UIView *dotTwo;
@property (nonatomic, strong)UIView *dotThree;
@property (nonatomic, strong)UIView *dotFour;
@property (nonatomic, strong)NSMutableArray <NSValue *>*pointList;
@property (nonatomic, strong)UIImageView *imgv;
@property (nonatomic, strong)NSArray *tempList;
@end

@implementation MMMoveDrawView

- (instancetype)initWithFrame:(CGRect)frame pointList:(NSArray <NSValue *>*)pointList
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pointList = [NSMutableArray array];
        
        pointOne = ((NSValue *)pointList[0]).CGPointValue;
        pointTwo = ((NSValue *)pointList[1]).CGPointValue;
        pointThree = ((NSValue *)pointList[2]).CGPointValue;
        pointFour = ((NSValue *)pointList[3]).CGPointValue;

        _imgv = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgv.contentMode = UIViewContentModeScaleAspectFill;
        _imgv.clipsToBounds = YES;
        [self addSubview:_imgv];
        
        UIPanGestureRecognizer *tap1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        _dotOne = [[UIView alloc] initWithFrame:CGRectMake(pointOne.x, pointOne.y,size, size)];
        _dotOne.backgroundColor = [UIColor redColor];
        [self addSubview:_dotOne];
        [_dotOne addGestureRecognizer:tap1];
        
        UIPanGestureRecognizer *tap2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        _dotTwo = [[UIView alloc] initWithFrame:CGRectMake(pointTwo.x, pointTwo.y, size, size)];
        _dotTwo.backgroundColor = [UIColor redColor];
        [self addSubview:_dotTwo];
        [_dotTwo addGestureRecognizer:tap2];
        
        UIPanGestureRecognizer *tap3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        _dotThree = [[UIView alloc] initWithFrame:CGRectMake(pointThree.x, pointThree.y, size, size)];
        _dotThree.backgroundColor = [UIColor redColor];
        [self addSubview:_dotThree];
        [_dotThree addGestureRecognizer:tap3];
        
        UIPanGestureRecognizer *tap4 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        _dotFour = [[UIView alloc] initWithFrame:CGRectMake(pointFour.x, pointFour.y, size, size)];
        _dotFour.backgroundColor = [UIColor redColor];
        [self addSubview:_dotFour];
        [_dotFour addGestureRecognizer:tap4];

        [self startDrawReact:pointList];

    }
    return self;
}
-(void)setImg:(UIImage *)img {
    _img = img;
    _imgv.image = img;
}
- (NSArray <NSValue *>*)pointList {
    return _pointList;
}

- (void)handlePan:(UIPanGestureRecognizer *)panGesture {
    
    if (panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint offset = [panGesture translationInView:panGesture.view];
        
        CGPoint tempCenter = panGesture.view.center;
        tempCenter.x += offset.x;
        tempCenter.y += offset.y;
        panGesture.view.center = tempCenter;
        
        if ([panGesture.view isEqual:_dotOne]) {
            pointOne = tempCenter;
//            pointOne = [self convertPoint:<#(CGPoint)#> toView:<#(nullable UIView *)#>
        }else if ([panGesture.view isEqual:_dotTwo]) {
            pointTwo = tempCenter;
        }else if ([panGesture.view isEqual:_dotThree]) {
            pointThree = tempCenter;
        }else if ([panGesture.view isEqual:_dotFour]) {
            pointFour = tempCenter;
        }
        
        
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
    }
    
    [self startDrawReact:nil];

}

- (void)startDrawReact:(NSArray <NSValue *>*)point {
    [self.shapeLayer removeFromSuperlayer];
    [self.fillLayer removeFromSuperlayer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
    
    //frame值相对于shapeLayer
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:pointOne];
    NSLog(@"%@", NSStringFromCGPoint(pointOne));
    [aPath addLineToPoint:pointTwo];
    [aPath addLineToPoint:pointThree];
    [aPath addLineToPoint:pointFour];
    [aPath closePath];
    
    [path appendPath:aPath];
//    [path setUsesEvenOddFillRule:YES];

    _fillLayer = [CAShapeLayer layer];
    _fillLayer.path = path.CGPath;
    //中间透明
    _fillLayer.fillRule = kCAFillRuleEvenOdd;
    //半透明效果
    _fillLayer.fillColor = [UIColor colorWithWhite:0.2 alpha:0.5].CGColor;
    _fillLayer.borderWidth = 3;
    [self.layer addSublayer:_fillLayer];
    
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    //self.center是相对于父视图的center
//    self.shapeLayer.position = self.center;
    self.shapeLayer.lineWidth = 2;
    self.shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.path = aPath.CGPath;
    self.shapeLayer.borderWidth = 3;
    [self.layer addSublayer:self.shapeLayer];
    
    [self bringSubviewToFront:_dotOne];
    [self bringSubviewToFront:_dotTwo];
    [self bringSubviewToFront:_dotThree];
    [self bringSubviewToFront:_dotFour];
    
    [_pointList removeAllObjects];
    [_pointList addObject:[NSValue valueWithCGPoint:pointOne]];
    [_pointList addObject:[NSValue valueWithCGPoint:pointTwo]];
    [_pointList addObject:[NSValue valueWithCGPoint:pointThree]];
    [_pointList addObject:[NSValue valueWithCGPoint:pointFour]];
    
}

@end
