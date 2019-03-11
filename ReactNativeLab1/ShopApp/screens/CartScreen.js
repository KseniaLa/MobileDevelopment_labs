import React from 'react';
import { StyleSheet, Text, View, Button, FlatList, TouchableOpacity, Image, Alert } from 'react-native';
import { Icon } from 'react-native-elements';
import { SQLite } from 'expo';
import images from './../imageContainer';

const db = SQLite.openDatabase('shop.db');

export default class CartScreen extends React.Component {
  constructor(props) {
    super(props);
    this.state = { data: [], count: 0 };
    this.props.navigation.addListener(
      'willFocus',
      _ => {
        this.update();
      }
    )
  }

  componentDidMount() {
    this.update();
    this.props.navigation.setParams({
      count: this.state.data.length,
      saveOrder: this.saveOrder.bind(this)
    });
  }

  static navigationOptions = ({ navigation }) => {
    const { params = {} } = navigation.state;
    return {
      headerTitle: "Cart",
      headerStyle: {
        backgroundColor: '#1E91FF',
      },
      headerTintColor: '#fff',
      headerTitleStyle: {
        fontWeight: 'bold',
      },
      headerRight: (
        <View style={styles.rowContainer}>
          {params.count > 0 && 
            <Icon
            reverse
            color='#0000ff'
            name="check"
            type='font-awesome'
            size={21}
            onPress={() => params.saveOrder()}
          />
          }
        </View>
      ),
    };
  }

  deleteItemFromCart = (itemId, count) => {
    let updateCount = (count) => {
      db.transaction(tx => {
        tx.executeSql('update items set count = count + ? where id = ?', [count, itemId], (_, res) => this.update(), (_, res) => console.log(res));
      })
    }
    db.transaction(tx => {
      tx.executeSql('delete from cart where item_id = ?', [itemId], (_, res) => {updateCount(count);}, (_, res) => console.log(res));
    })
  };

  update() {
    db.transaction(tx => {
      tx.executeSql(
        `select items.id, name, description, image, price, items.count, cart.count as booked from items, cart where cart.item_id = items.id;`,
        [],
        (_, { rows: { _array } }) => {
          this.setState({ data: _array});
          this.props.navigation.setParams({
            count: _array.length,
          });
        },
        (t, error) => console.log(error),
      );
    });
  }

  saveOrder() {
    db.transaction(tx => {
      tx.executeSql(
        `delete from cart;`,
        [],
        (_, res) => {
          this.update();
          Alert.alert(
            'Success',
            'Order saved, cart is empty',
            [{text: 'OK'}]
          );
        },
        (t, error) => console.log(error),
      );
    });
  }

  renderListItem = ({ item }) => (
    <ListItem
      id={item.id}
      onPressItem={this._onPressItem}
      name={item.name}
      description={item.description}
      price={item.price}
      count={item.booked}
      image={item.image}
      onPressDelete={this.deleteItemFromCart}
    />
  );

  _onPressItem = (itemId, count) => {
    const { navigate } = this.props.navigation;
    navigate('Details', { id: itemId, isCartItem: true, currentCount: count })
  };

  _keyExtractor = (item) => `${item.id}`; 

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
    this.props.onPressItem(this.props.id, this.props.count);
  }

  onPressDelete = () => {
    this.props.onPressDelete(this.props.id, this.props.count);
  }

  render() {
    return (
      <TouchableOpacity onPress={this._onPress}>
        <View style={styles.listItem} key={this.props.id}>
          <Image
            source={this.props.image ? images[this.props.image] : require('./../images/empty-image.png')}
            style={{ width: 100, height: 100, margin: 5 }}
            resizeMode="contain"
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
            onPress={() => this.onPressDelete()}
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