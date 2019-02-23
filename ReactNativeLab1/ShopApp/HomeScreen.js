import React from 'react';
import { StyleSheet, Text, View, Button, } from 'react-native';
import { SearchBar } from 'react-native-elements';
import Grid from 'react-native-grid-component';

export default class HomeScreen extends React.Component {
  static navigationOptions = ({ navigation }) => {
    return {
      headerTitle: "Catalog",
      headerStyle: {
        backgroundColor: '#f4511e',
      },
      headerTintColor: '#fff',
      headerTitleStyle: {
        fontWeight: 'bold',
      },
      headerRight: (
        <View style={styles.rowContainer}>
        <SearchBar
        placeholder="Type Here..."
        />
        <Button
        onPress={() => navigation.navigate('Cart')}
        title="Info"
        color="#faa"
      />
      </View>
      ),
    };
  }

  renderItem = (data, i) => {
    const {navigate} = this.props.navigation;
    return (
      <View style={[{ backgroundColor: data }, styles.item]} key={i}>
        <Button title="Go"
          onPress={() => navigate('Details', {name: 'Jane'})}>
        </Button>
      </View>
    )
  }

  renderPlaceholder = i => <View style={styles.item} key={i} />;

  render() {
    
    return(
      <Grid
        style={styles.list}
        renderItem={this.renderItem}
        renderPlaceholder={this.renderPlaceholder}
        data={['black', 'white', 'red', 'green', 'blue', 'orange', 'yellow', 'green']}
        itemsPerRow={3}
      />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    padding: 8,
    backgroundColor: "#ffffff",
  },
  rowContainer: {
    flexDirection: 'row',
    margin: 1
  },
  item: {
    flex: 1,
    height: 160,
    margin: 1
  },
  list: {
    flex: 1
  },
}); 