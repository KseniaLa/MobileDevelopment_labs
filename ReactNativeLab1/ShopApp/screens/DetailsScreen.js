import React from 'react';
import { StyleSheet, Text, View, Image, ScrollView, Button } from 'react-native';
import IconBadge from 'react-native-icon-badge';
import { Icon } from 'react-native-elements';
import NumericInput from 'react-native-numeric-input';
import { SQLite } from 'expo';
import images from './../imageContainer';

const db = SQLite.openDatabase('shop.db');

export default class DetailsScreen extends React.Component {
  constructor(props) {
    super(props);
    const { navigation } = this.props;
    const itemId = navigation.getParam('id', 'NO-ID');
    const currCount = navigation.getParam('currentCount', 0);
    this.state = { id: itemId, data: {}, count: currCount == 0 ? 1 : currCount, currentCount: currCount };
  }
 
  getItemData() {
    db.transaction(tx => {
      tx.executeSql(
        `select * from items where id = ?;`,
        [this.state.id],
        (_, { rows: { _array } }) => this.setState({ data: _array[0] })
      );
    });
  }

  updateItemCount() {
    db.transaction(tx => {
      tx.executeSql('update items set count = count + ? - ? where id = ?', [this.state.currentCount, this.state.count, this.state.id], null, (_, err) => console.log(err));
    });
  }

  addToCart() {
    db.transaction(tx => {
      tx.executeSql('insert into cart (item_id, count) values (?, ?)', [this.state.id, this.state.count],
        (_, { rows }) => {
          alert('Added to cart');
          this.updateItemCount();
        }, (_, err) => alert('Item exists in cart'));
    });

    this.updateCartCount();
  }

  updateCart() {
    db.transaction(tx => {
      tx.executeSql('update cart set count = ? where item_id = ?', [this.state.count, this.state.id],
        (_, { rows }) => {
          alert('Count updated');
          this.updateItemCount();
        }, (_, err) => alert('Error updating cart'));
    });
  }

  updateCartCount() {
    db.transaction(tx => {
      tx.executeSql(
        `select count(*) as cnt from cart;`,
        [],
        (_, { rows: { _array } }) => this.props.navigation.setParams({ cartCount: _array[0].cnt }),
        (_, res) => this.props.navigation.setParams({ cartCount: 0 })
      );
    });
  }

  componentDidMount() {
    this.getItemData();
    this.updateCartCount();
    this.props.navigation.setParams({
      addToCart: this.addToCart.bind(this),
      updateCart: this.updateCart.bind(this)
    });
  }

  static navigationOptions = ({ navigation }) => {
    const { params = {} } = navigation.state;
    return {
      headerStyle: {
        backgroundColor: '#1E91FF',
      },
      headerTintColor: '#fff',
      headerTitleStyle: {
        fontWeight: 'bold',
      },
      headerRight: (
        <View style={styles.rowContainer}>
          {!params.isCartItem &&
            <>
              <IconBadge
                MainElement={
                  <Icon
                    reverse
                    color='#0000FF'
                    name="shopping-cart"
                    type='font-awesome'
                    size={21}
                    onPress={() => navigation.navigate('Cart')}
                  />
                }
                BadgeElement={
                  <Text style={{ color: '#FFFFFF' }}>{params.cartCount}</Text>
                }
                IconBadgeStyle={
                  {
                    top: 4,
                    right: 4,
                    width: 20,
                    height: 20,
                    fontWeight: 10,
                    backgroundColor: '#ff0000'
                  }
                }
                Hidden={params.cartCount === 0}
              />
              <Icon
                reverse
                color='#0000ff'
                name="cart-plus"
                type='font-awesome'
                size={21}
                onPress={() => params.addToCart()}
              />
            </>
          }
          {params.isCartItem && 
            <Icon
            reverse
            color='#0000ff'
            name="check"
            type='font-awesome'
            size={21}
            onPress={() => params.updateCart()}
          />
          }
        </View>
      ),
    };
  }

  render() {
    let item = this.state.data;
    return (

      <ScrollView>
        <View style={{ flex: 1, alignItems: "center" }}>
          <Image
            source={item.image ? images[item.image] : require('./../images/empty-image.png')}
            resizeMode="contain"
            style={styles.image}
          />

          <NumericInput
            type='plus-minus'
            value={this.state.count}
            minValue={1}
            maxValue={item.count + this.state.currentCount}
            onChange={value => this.setState({ count: value })}
            rounded
            textColor='#B0228C'
            iconStyle={{ color: 'white' }}
            rightButtonBackgroundColor='#0000ff'
            leftButtonBackgroundColor='#0000ff'
            borderColor='#0000ff'
            initValue={this.state.count}
          />
          <Text>Model: {item.name}</Text>
          <Text>Description: {item.description}</Text>
          <Text>Price: {item.price}</Text>
          <Text>Available count: {item.count}</Text>
        </View>
      </ScrollView>


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
  rowContainer: {
    flexDirection: 'row',
    margin: 1,
    justifyContent: "center"
  },
  item: {
    flex: 1,
    height: 160,
    margin: 1
  },
  list: {
    flex: 1
  },
  image: {
    width: '80%',
    margin: 5,
    height: 250
  },
  button: {
    height: 30
  }
});