import React from 'react';
import { StyleSheet, Text, View, Image } from 'react-native';
import appData from './../data';

export default class DetailsScreen extends React.Component {
  render() {
    const { navigation } = this.props;
    const itemId = navigation.getParam('id', 'NO-ID');
    return(
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
      <Image
            source={require('./../images/empty-image.png')}
            style={{ width: 100, height: 100, margin: 5 }}
          />
        <Text>Model: {appData[itemId].name}</Text>
        <Text>Description: {appData[itemId].description}</Text>
        <Text>Price: {appData[itemId].price}</Text>
        <Text>Available count: {appData[itemId].count}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffa',
    alignItems: 'center',
    justifyContent: 'center',
  },
  item: {
    flex: 1,
    height: 160,
    margin: 1
  },
  list: {
    flex: 1
  }
});