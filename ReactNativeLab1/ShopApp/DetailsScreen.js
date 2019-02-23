import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default class DetailsScreen extends React.Component {
  render() {
    return(
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
        <Text>Hello world!!!</Text>
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