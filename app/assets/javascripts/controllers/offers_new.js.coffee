Roomnhouse.OffersNewController = Ember.Controller.extend
  needs: ['currentUser']
  queryParams: ['user_id']
  user_id: null
  actions:
    createOffer: ->
      user = @store.getById('user', @get('user_id'))
      console.log(user)
      offer = @store.createRecord('offer', @get('fields') )
      offer.set('user', user)
      offer.save().then =>
        @transitionToRoute 'offer', offer