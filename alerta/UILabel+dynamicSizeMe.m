#import "UILabel+dynamicSizeMe.h"

@implementation UILabel (dynamicSizeMe)

-(float)resizeToFit{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];

    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,999999);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font] 
                                            constrainedToSize:maximumLabelSize
                                            lineBreakMode:[self lineBreakMode]]; 
    return expectedLabelSize.height;
}

-(float)expectedWidth{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByClipping];
    
    CGSize maximumLabelSize = CGSizeMake(999999,self.frame.size.height);
    
    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:[self lineBreakMode]];
    return expectedLabelSize.width;
}


@end
