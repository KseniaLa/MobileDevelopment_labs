import React from 'react';
import { StyleSheet, Text, View, Button, } from 'react-native';
import { SearchBar, Icon } from 'react-native-elements';
import IconBadge from 'react-native-icon-badge';
import Grid from 'react-native-grid-component';

export default class HomeScreen extends React.Component {
  constructor(props) {
    super(props);
    this.state = { cartCount: 5, isTabs: true };
  }

  componentDidMount() {
    this.props.navigation.setParams({
      cartCount: this.state.cartCount,
      toggleListView: this.toggleListAppearance.bind(this),
      listView: this.state.isTabs
    });
  }

  toggleListAppearance() {
    let isTabsVal = this.state.isTabs;
    this.setState({ isTabs: false });
    this.props.navigation.setParams({
      listView: false,
    });
  }

  static navigationOptions = ({ navigation }) => {
    const { params = {} } = navigation.state;
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
          <Icon
            reverse
            color='#517fa4'
            name={params.listView ? "view-list" : "dashboard"}
            type='material'
            onPress={() => params.toggleListView()}
          />

          <IconBadge
            MainElement={
              <Icon
                reverse
                color='#517fa4'
                name="shopping-cart"
                type='font-awesome'
                onPress={() => navigation.navigate('Cart')}
              />
            }
            BadgeElement={
              <Text style={{ color: '#FFFFFF' }}>{params.cartCount}</Text>
            }
            IconBadgeStyle={
              {
                width: 20,
                height: 20,
                backgroundColor: '#FF00EE'
              }
            }
            Hidden={params.cartCount === 0}
          />


        </View>
      ),
    };
  }

  renderItem = (data, i) => {
    const { navigate } = this.props.navigation;
    return (
      <View style={[{ backgroundColor: data }, styles.item]} key={i}>
        <Button title="Go"
          onPress={() => navigate('Details', { name: 'Jane' })}>
        </Button>
      </View>
    )
  }

  renderPlaceholder = i => <View style={styles.item} key={i} />;

  render() {

    return (
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