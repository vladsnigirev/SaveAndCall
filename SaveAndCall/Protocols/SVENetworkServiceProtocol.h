//
//  SVENetworkServiceProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 30/01/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

//Протокол, для обработки полученных данных из сети
@protocol SVENetworkServiceProtocol <NSObject>


@optional
- (void)loadingIsDoneWithDataReceived:(NSData *)data;


@end
