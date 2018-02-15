//
//  SVENetworkServiceProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

//Протокол, для получения данных.
@protocol SVENetworkServiceProtocol <NSObject>

@optional
- (void)loadingIsDoneWithDataReceived:(NSData *)data;

@end
