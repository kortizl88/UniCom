import { UniformesPage } from './app.po';

describe('uniformes App', () => {
  let page: UniformesPage;

  beforeEach(() => {
    page = new UniformesPage();
  });

  it('should display welcome message', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('Welcome to app!');
  });
});
