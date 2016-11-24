//
//  MethodsCache.h
//  Meanwhile22
//
//  Created by Michael Hoffman on 11/23/16.
//  Copyright © 2016 Here We Go. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MethodsCache : NSObject

-(UIColor*)colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha;
-(void)createButtonBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array;
-(void)createViewBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array;
-(void)createImageBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array;
-(void)createLabelBorderWidth:(NSInteger)width color:(UIColor *)color forArray:(NSArray *)array;

@end
