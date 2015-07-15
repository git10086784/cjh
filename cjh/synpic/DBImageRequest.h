
#import <Foundation/Foundation.h>

typedef void (^DBRequestSuccessHandler)(UIImage *image, NSHTTPURLResponse *response);
typedef void (^DBRequestErrorHandler)(NSError *error);

@interface DBImageRequest : NSObject

- (id) initWithURLRequest:(NSURLRequest*)request;
- (void) downloadImageWithSuccess:(DBRequestSuccessHandler)success error:(DBRequestErrorHandler)error;
- (void) cancel;

@end
