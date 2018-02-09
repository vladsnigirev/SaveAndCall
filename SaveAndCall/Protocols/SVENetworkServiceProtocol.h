//
//  SVENetworkServiceProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

@protocol SVENetworkServiceProtocol <NSObject>

- (void)loadingIsDoneWithDataReceived:(NSData *)data;

@end
