import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default class CartScreen extends React.Component {
  render() {
    return(
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        <Text>Cart</Text>
      </View>
    );
  }
}