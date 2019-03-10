import React from 'react';
import { StyleSheet, Text, View, Button, FlatList, TouchableOpacity, Image } from 'react-native';
import { Icon } from 'react-native-elements';
import appData from './../data';

export default class CartScreen extends React.Component {
  constructor(props) {
    super(props);
    this.state = { cartCount: 5, data: appData };
  }

  renderListItem = ({ item }) => (
    <ListItem
      id={item.id}
      onPressItem={this._onPressItem}
      name={item.name}
      description={item.description}
      price={item.price}
      count={item.count}
    />
  );

  _onPressItem = (itemId) => {
    const { navigate } = this.props.navigation;
    navigate('Details', { id: itemId, isCartItem: true })
  };

  _keyExtractor = (item, index) => item.id;

  render() {
    return (
      <FlatList
        data={this.state.data}
        style={{backgroundColor: "#dcdcdc"}}
        keyExtractor={this._keyExtractor}
        renderItem={this.renderListItem}
      />
    );
  }
}



class ListItem extends React.PureComponent {
  _onPress = () => {
    this.props.onPressItem(this.props.id);
  }

  render() {
    return (
      <TouchableOpacity onPress={this._onPress}>
        <View style={styles.listItem} key={this.props.id}>
          <Image
            source={require('./../images/empty-image.png')}
            style={{ width: 100, height: 100, margin: 5 }}
          />
          <View style={styles.listItemInfo}><Text numberOfLines={1} style={styles.listName}>{this.props.name}</Text>
            <Text numberOfLines={3} style={styles.listDescription}>{this.props.description}</Text>
            <Text style={styles.price}>{this.props.price} $</Text>
            <Text style={styles.count}>{this.props.count}</Text>
            
          </View>
          <Icon
            reverse
            color='#FFFAFA'
            iconStyle={{color: '#ff0000'}}
            name="trash"
            type='font-awesome'
            size={21}
            onPress={() => alert('lol')}
          />
        </View>
      </TouchableOpacity>
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
  listItem: {
    flex: 1,
    flexDirection: 'row',
    height: 130,
    margin: 1,
    marginTop: 5,
    marginBottom: 5,
    backgroundColor: "white"
  },
  listItemInfo: {
    flex: 1,
    flexDirection: 'column'
  },
  list: {
    flex: 1,
    alignItems: 'stretch',
  },
  listName: {
    padding: 3,
    fontWeight: 'bold',
    flexWrap: "wrap",
    width: '80%',
  },
  listDescription: {
    flex: 1,
    width: '80%',
    flexWrap: "wrap",
    fontSize: 10
  },
  price: {
    color: "#0000ff",
  },
  count: {
    backgroundColor: "#0000ff",
    width: '50%',
    textAlign: "center",
    color: "#ffffff"
  }
}); 