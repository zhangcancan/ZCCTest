//
//  UIImage+Common.m
//  Pods
//
//  Created by l on 15/4/27.
//
//

#import "UIImage+Common.h"

@implementation UIImage (Common)
- (UIImage*) resizeInArea : (CGSize) area {
    CGSize size = self.size;
    
    if (size.width <= area.width && size.height <= area.height) return self;
    
    float tw = area.width / size.width;
    float th = area.height / size.height;
    float b =  tw < th ? tw : th;
    
    CGSize tmp = CGSizeMake(b*size.width, b*size.height);
    
    UIGraphicsBeginImageContext(tmp);
    
    CGRect imageRect = CGRectMake(0, 0, tmp.width, tmp.height);
    
    [self drawInRect:imageRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)imageByCropToRect:(CGRect)rect {
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}
@end
