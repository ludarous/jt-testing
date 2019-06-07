import {AfterViewInit, Component, ElementRef, Input, OnInit, ViewChild} from '@angular/core';

@Component({
  selector: 'app-sidebar-menu-item',
  templateUrl: './sidebar-menu-item.component.html',
  styleUrls: ['./sidebar-menu-item.component.scss']
})
export class SidebarMenuItemComponent implements OnInit, AfterViewInit {


  constructor() { }

  @Input()
  menuItem: any;

  @ViewChild('itemContent')
  private itemContent: ElementRef;

  @Input()
  parent: SidebarMenuItemComponent;

  @Input()
  level = 0;

  self: SidebarMenuItemComponent;

  get hasItems(): boolean {
    return this.menuItem.items && this.menuItem.items.length > 0;
  }

  ngOnInit() {
    this.menuItem.collapsed = true;

    this.self = this;
  }

  ngAfterViewInit(): void {
    this.setCollapsed();
  }

  setCollapsed() {
    if (this.itemContent) {
      const element = this.itemContent.nativeElement;
      element.style.height = '0px';
    }
  }

  toggle() {
    if (this.menuItem.collapsed) {
      this.expandContent();
      this.menuItem.collapsed = false;
    } else {
      this.collapseContent();
      this.menuItem.collapsed = true;
    }
  }

  collapseContent() {
    const element = this.itemContent.nativeElement;
    if (this.parent) {
      const parentElement = this.parent.itemContent.nativeElement;
      parentElement.style.height = 'auto';
    }

    // get the height of the element's inner content, regardless of its actual size
    const sectionHeight = element.scrollHeight;

    // temporarily disable all css transitions
    const elementTransition = element.style.transition;
    element.style.transition = '';

    // on the next frame (as soon as the previous style change has taken effect),
    // explicitly set the element's height to its current pixel height, so we
    // aren't transitioning out of 'auto'
    requestAnimationFrame(function() {
      element.style.height = sectionHeight + 'px';
      element.style.transition = elementTransition;

      // on the next frame (as soon as the previous style change has taken effect),
      // have the element transition to height: 0
      requestAnimationFrame(function() {
        element.style.height = 0 + 'px';
      });
    });
  }

  expandContent() {
   if (this.parent) {
     const parentElement = this.parent.itemContent.nativeElement;
     parentElement.style.height = 'auto';
   }

    const element = this.itemContent.nativeElement;

    // get the height of the element's inner content, regardless of its actual size
    const sectionHeight = element.scrollHeight;

    // have the element transition to the height of its inner content
    element.style.height = sectionHeight + 'px';

    // when the next css transition finishes (which should be the one we just triggered)
    element.addEventListener('transitionend', function(e) {
      // remove this event listener so it only gets triggered once
      element.removeEventListener('transitionend', arguments.callee);

      // remove "height" from the element's inline styles, so it can return to its initial value
      element.style.height = 'auto';
    });

  }

}
