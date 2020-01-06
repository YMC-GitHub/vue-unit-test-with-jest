//----------test-----------
//it is a test file for list sfc
//----------test-----------
//tasks:
//use vue test-utils
//mount sfc file
//test rendered HTML output of some component
//mount a component without rendering its child components
//match Snapshot

//include some lib
import { shallowMount } from '@vue/test-utils'

//include some file to test
import List from '@/components/List.vue'

describe('List.vue', () => {
  it('renders li for each item in props.items', () => {
    const items = ['1', '2']
    //mount sfc file
    const wrapper = shallowMount(List, {
      propsData: { items }
    })
    //test rendered HTML output of some component
    expect(wrapper.findAll('li')).toHaveLength(items.length)
  })

  it('matches snapshot', () => {
    const items = ['item 1', 'item 2']
    const wrapper = shallowMount(List, {
      propsData: { items }
    })
    expect(wrapper.html()).toMatchSnapshot()
  })
})
