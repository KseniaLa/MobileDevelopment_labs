import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Grid from 'react-native-grid-component';
import {createStackNavigator, createAppContainer} from 'react-navigation';
import HomeScreen from './screens/HomeScreen';
import DetailsScreen from './screens/DetailsScreen';
import CartScreen from './screens/CartScreen'

const MainNavigator = createStackNavigator({
  Home: HomeScreen,
  Details: DetailsScreen,
  Cart: CartScreen
});

const App = createAppContainer(MainNavigator);

export default App;