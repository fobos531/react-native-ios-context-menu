import type {  ViewProps } from 'react-native';

import type { RNIContextMenuButtonBaseProps } from '../../native_components/RNIContextMenuButton';
import type { ContextMenuViewProps } from '../ContextMenuView';


export type ContextMenuButtonBaseProps = Partial<Pick<RNIContextMenuButtonBaseProps,
  | 'internalCleanupMode'
  | 'isMenuPrimaryAction'
  | 'menuConfig'
  | 'isContextMenuEnabled'
  // Lifecycle Events
  | 'onMenuWillShow'
  | 'onMenuWillHide'
  | 'onMenuWillCancel'
  | 'onMenuDidShow'
  | 'onMenuDidHide'
  | 'onMenuDidCancel'
  // `OnPress` Events
  | 'onPressMenuItem'
> & Pick<ContextMenuViewProps,
  | 'onRequestDeferredElement'
>> & {
  useActionSheetFallback?: boolean;
};

export type ContextMenuButtonProps = 
  ViewProps & ContextMenuButtonBaseProps;

export type ContextMenuButtonState = {
  menuVisible: boolean;
};
