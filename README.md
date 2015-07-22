# BubblePhotoImageView
一个不规则图片气泡解决方案，图片撑到了边角

![示例2](https://github.com/Natoto/BubblePhotoImageView/blob/master/IMG_1690.PNG)
![示例](https://github.com/Natoto/BubblePhotoImageView/blob/master/IMG_1689.PNG)
*核心代码如下
```object-c
/**
 *  得到mask的图像
 *
 *  @param BubbleImage 气泡原始图
 *  @param edge        拉伸角度
 *  @param maskframe   蒙版大小
 *
 *  @return 返回蒙版图像
 */
-(UIImage *)getMaskImageWithBubbleImage:(UIImage *)BubbleImage  EdgeInsets:(UIEdgeInsets)edgeInsets maskframe:(CGRect)maskframe
{
    BubbleImage = [BubbleImage stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top];// : [BubbleImage resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])
    
    UIGraphicsBeginImageContextWithOptions(maskframe.size, NO, 0);
    [BubbleImage drawInRect:CGRectMake(0, 0, maskframe.size.width, maskframe.size.height)];
    CGRect rect = CGRectMake(edgeInsets.left, 0, maskframe.size.width - 2 * edgeInsets.left, maskframe.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIImage * image3 = img ;
    return image3;
}
```
