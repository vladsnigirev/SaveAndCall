//
//  SVEModelCleanerProtocol.h
//  SaveAndCall
//
//  Created by Влад Снигирев on 15/02/2018.
//  Copyright © 2018 Vlad Snigiryov. All rights reserved.
//

//Протоколо очистки моделей. Используется При сменах экрана.
@protocol SVEModelCleanerProtocol <NSObject>

@required
- (void)clearModels;

@end
